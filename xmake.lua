includes("build_proj.lua")
target("mimalloc")
_config_project({
	project_kind = "shared",
	no_rtti = true
})
on_load(function(target)
	local function rela(p)
		return path.relative(path.absolute(p, os.scriptdir()), os.projectdir())
	end
	target:add("includedirs", rela("include"), {
		public = true
	})
	target:add("defines", "MI_SHARED_LIB", {
		public = true
	})
	target:add("defines", "MI_SHARED_LIB_EXPORT", "MI_XMALLOC=1", "MI_WIN_NOREDIRECT")
	if is_plat("windows") then
		target:add("syslinks","psapi", "shell32", "user32", "advapi32", "bcrypt")
		target:add("defines", "_CRT_SECURE_NO_WARNINGS")
	elseif is_plat("linux") then
		target:add("syslinks","pthread", "atomic")
	else
		target:add("syslinks","pthread")
	end
end)
add_headerfiles("include/*.h")
add_files("src/static.c")
target_end()
