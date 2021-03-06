require ("base.functions")

BaseUI = BaseUI or BaseClass()

function BaseUI:__init(viewType)
	self.autoGameEvent = {}
	self.rootNode = cc.Node:create()
	if UIConfig.viewType.FullScreen == viewType then
		self:initFullScreen()
	end
end

function BaseUI:__delete()

end

function BaseUI:setContenSize(size)
	self.rootNode:setContentSize(size)
end

function BaseUI:addChild(node,zorder,tag)
	--zorder = zorder or 0
	--tab = tag or 0
	--node:setLocalZOrder(1)
	--node:setTag(tag)
	--node:setParent(self.rootNode)
	self.rootNode:addChild(node)
end

function BaseUI:getRootNode()
	return self.rootNode
end

function BaseUI:registerShowCallback(callback)
	self.showCallback = callback
end

function BaseUI:registerHideCallback(callback)
	self.hideCallback = callback
end

function BaseUI:addEvent(eventName, func)
	if eventName and func and type(eventName) == "string" and type(func) == "function" and not self.autoGameEvent[eventName] then
		self.autoGameEvent[eventName] = {}
		self.autoGameEvent[eventName].eventObject = GlobalEventSystem:Bind(eventName, func)
		self.autoGameEvent[eventName].func = func
		return true
	end
	return false
end

function BaseUI:removeEvent(eventName)
	if eventName and self.autoGameEvent[eventName] then
		if self.autoGameEvent[eventName].eventObject then
			GlobalEventSystem:UnBind(self.autoGameEvent[eventName].eventObject)
		end
		self.autoGameEvent[eventName] = nil
	end
end

function BaseUI:bindAutoEvent()
	if not self.autoGameEvent then
		return
	end
	for k,v in pairs(self.autoGameEvent) do
		if v and not v.eventObject then
			v.eventObject = GlobalEventSystem:Bind(k, v.func)
		end
	end
end

function BaseUI:unbindAutoEvent()
	if not self.autoGameEvent then
		return
	end
	for k,v in pairs(self.autoGameEvent) do
		if v and v.eventObject then
			GlobalEventSystem:UnBind(v.eventObject)
			v.eventObject  = nil
		end
	end
end

function BaseUI:onEnter()
	self:bindAutoEvent()
	if self.showCallback then
		self.showCallback()
	end
end

function BaseUI:onExit()
	self:unbindAutoEvent()
	if self.hideCallback then
		self.hideCallback()
	end
end

function BaseUI:close()
	UIManager.Instance:hideUI(self.viewName)
end

function BaseUI:initFullScreen()
	local winSize = cc.Director:getInstance():getWinSize()
	self:setContenSize(winSize)
end