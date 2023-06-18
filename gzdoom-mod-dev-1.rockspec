---	@diagnostic disable: lowercase-global

package = "gzdoom-mod"
version = "dev-1"
source = {
	url = "nil"
}
description = {
	homepage = "nil",
	license = "nil"
}
build = {
	type = "builtin",
	modules = {}
}
dependencies = {
	"ansikit ~> 1.0",
	"argparse ~> 0.7",
	"busted ~> 2.1",
	"lua-glob-pattern ~> 0.2",
	"luafilesystem ~> 1.8",
	"lyaml ~> 6.2",
	"penlight ~> 1.13"
}
