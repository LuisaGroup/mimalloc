includes("build_proj.lua")
target("mimalloc")
_config_project({
	project_kind = "shared",
	no_rtti = true
})
add_includedirs("include", {
	public = true
})
add_defines("MI_SHARED_LIB", {
	public = true
})
add_defines("MI_SHARED_LIB_EXPORT", "MI_XMALLOC=1", "MI_WIN_NOREDIRECT")
add_files("src/static.c")
if is_plat("windows") then
	add_syslinks("psapi", "shell32", "user32", "advapi32", "bcrypt")
	add_defines("_CRT_SECURE_NO_WARNINGS")
elseif is_plat("linux") then
	add_syslinks("pthread", "atomic")
else
	add_syslinks("pthread")
end
target_end()
