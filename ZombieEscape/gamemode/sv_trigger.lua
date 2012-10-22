GM.Triggers = {}
GM.Triggers.Config = {}
GM.Triggers.Entities = {}

function GM:AddTrigger( vMin, vMax, Function, bRemoveOnTouch )

	if !vMin or !vMax then return end

	local trigger = {
		min = vMin,
		max = vMax,
		f = Function,
		rm = bRemoveOnTouch and bRemoveOnTouch or false
	}

	table.insert(self.Triggers.Config, trigger)

end

function GM:CreateTriggers()

	self.Triggers.Entities = {}

	for _, v in pairs(self.Triggers.Config) do

		local ent = ents.Create("trigger_ze")
		ent:Setup(v.min,v.max,v.f,v.rm)
		ent:Spawn()
		ent:Activate()

		table.insert(self.Triggers.Entities, ent)
	end

end