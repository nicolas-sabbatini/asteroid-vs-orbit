-- Configuration
function love.conf(t)

	t.version = '11.1'
	t.window.title = 'Asteroid vs Orbit'

	t.identity = 'asteroid-vs-orbit'

	t.releases = {
		title = 'Asteroid vs Orbit',            -- The project title (string)
		package = nil,                          -- The project command and package name (string)
		loveVersion = '11.1',                   -- The project LÖVE version
		version = nil,                          -- The project version
		author = 'Nicolas',                     -- Your name (string)
		email = nil,                            -- Your email (string)
		description = 'Small open source game', -- The project description (string)
		homepage = 'https://goo.gl/v83v48',     -- The project homepage (string)
		identifier = nil,                       -- The project Uniform Type Identifier (string)
		excludeFileList = {},                   -- File patterns to exclude. (string list)
		releaseDirectory = '../bin',            -- Where to store the project releases (string)
	  }
end