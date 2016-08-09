
function init()
	--printTable(0, _ENV)
	if projectile.sourceEntity() and world.entityExists(projectile.sourceEntity()) then
		-- sb.logInfo("portal|update: SrcEnt = " .. tostring(projectile.sourceEntity()))
		
		-- sb.logInfo(tostring(activeItem.ownerAimPosition()))
		--sb.logInfo(tostring(projectile.sourceEntity()))
		--local itemDescriptorPrimary = world.entityHandItemDescriptor(projectile.sourceEntity(), "primary")
		--sb.logInfo(tostring(itemPrimary))
		--sb.logInfo(tostring(activeItem))
		-- sb.logInfo(tostring(config.getParameter("aimPosition")))
		-- printTable(0, config.getParameter("aimPosition"))
	end
end

function update()
	--sb.logInfo("portal|update: " .. tostring())
    local posCurrent = mcontroller.position()
	if mcontroller.isColliding() then
        --sb.logInfo("collided")
		projectile.die()
        createPortal(posCurrent)
        return
	end
	local posTarget = config.getParameter("aimPosition")
	local deviation = 0.6
	-- sb.logInfo(tostring(posCurrent[1]) .. " : " .. tostring(posTarget[1]))
	-- sb.logInfo(tostring(posCurrent[2]) .. " : " .. tostring(posTarget[2]))
	local minX = posTarget[1] - deviation
	local maxX = posTarget[1] + deviation
	local minY = posTarget[2] - deviation
	local maxY = posTarget[2] + deviation
	if posCurrent[1] >= minX and posCurrent[1] <= maxX and posCurrent[2] >= minY and posCurrent[2] <= maxY then
		projectile.die()
        createPortal(posCurrent)
	end
end

function createPortal(posCurrent)
	world.placeObject("portal", posCurrent)
end

-- Print table things

function printTable(indent, value)
    local tabs = "";
    for i=1,indent,1 do
        tabs = tabs.."    ";
    end
    table.sort(value)
    for k,v in pairs(value) do
        sb.logInfo(tabs..getValueOutput(k,v));
        if type(v) == "table" then
            if tostring(k) == "utf8" then
                sb.logInfo("    "..tabs.."SKIPPING UTF8")-- SINCE IT SEEMS TO HAVE NO END AND JUST BE FILLED WITH TABLES OF TABLES
            else
                if tableLen(v) == 0 then
                    sb.logInfo("    "..tabs.."EMPTY TABLE")
                else
                    printTable(indent+1,v);
                 
                end
            end
            sb.logInfo(" ");
        end
    end
 
end
 
function tableLen(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
 
--Required for printTable
function getValueOutput(key ,value)
    if type(value) == "table" then
        return "table : "..key;
    elseif type(value) == "function" then
        return "function : "..key.."()"
    elseif type(value) == "string" then
        return "string : "..key.." - \""..tostring(value).."\"";
    else
        return type(value).." : "..key.." - "..tostring(value);
    end
end
