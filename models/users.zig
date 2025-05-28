const std = @import("std"); // importing the standard library
pub const MAX_Power = 10000;
pub const User = struct {
    power: u64,
    name: []const u8,

    pub const SUPER_Power = 9000;

    pub fn diagnose(user: User) void {
        if (user.power >= SUPER_Power) {
            std.debug.print("its over {d}\n", .{SUPER_Power});
        }
    }
};
