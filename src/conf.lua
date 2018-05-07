-- Configuration
function love.conf(t)

	t.version = '11.1'
	t.window.title = 'Orbitz'

	t.identity = 'Orbitz'

	t.releases = {
		title = 'Orbitz',              -- The project title (string)
		package = nil,            -- The project command and package name (string)
		loveVersion = '11.1',        -- The project LÖVE version
		version = nil,            -- The project version
		author = 'Nicolas',             -- Your name (string)
		email = nil,              -- Your email (string)
		description = 'Small game for a game jam',        -- The project description (string)
		homepage = nil,           -- The project homepage (string)
		identifier = nil,         -- The project Uniform Type Identifier (string)
		excludeFileList = {},     -- File patterns to exclude. (string list)
		releaseDirectory = '../bin',   -- Where to store the project releases (string)
	  }
end