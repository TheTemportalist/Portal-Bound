
function update()
	if projectile.sourceEntity() and world.entityExists(projectile.sourceEntity()) then
		-- projectile.die()
		-- sb.logInfo(tostring(project.sourceEntity()))
	end
	if projectile.collision() then
		sb.logInfo("portalblue|update: collided")
		projectile.die()
	end
end
