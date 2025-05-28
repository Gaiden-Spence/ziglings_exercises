const std = @import("std"); // importing the standard library

pub fn main() !void {
    std.debug.print("{any}\n", .{anniversaryName(1)});
    std.debug.print("{any}\n", .{arrivalTimeDesc(16, true)});
    std.debug.print("{any}\n", .{contains(&[_]u32{ 12, 56, 69 }, 12)}); //size and type of the array must be declared when passing array into function as a parameter

    for (0..10) |i| {
        std.debug.print("{d}\n", .{i}); // how to run a basic for loop in zig
    }
    std.debug.print("{any}\n", .{eql(u32, &[_]u32{ 12, 45 }, &[_]u32{ 12, 46 })});
    std.debug.print("{any}\n", .{indexOf(&[_]u32{ 513, 83, 12, 4 }, 16)});

    //while loops in zig
    var escape_count: usize = 0;
    var i: usize = 0;
    const src = "fred\\fred\\burger";
    while (i < src.len) { //while loop practice and we see if to see if there are any escape sequences
        if (src[i] == '\\') {
            i += 2;
            escape_count += 1;
        } else {
            i += 1;
        }
    }

    //nested loops in zig
    std.debug.print("{d}\n", .{escape_count});
    outer: for (1..10) |k| {
        for (k..10) |j| {
            if (k * j > (k + k + j + j)) continue :outer;
            std.debug.print("{d} + {d} >= {d} * {d}\n", .{ k + k, j + j, k, j });
        }
    }

    //break statements in zig
    const tea_vote: u8 = 6;
    const coffee_vote: u8 = 56;
    const personality_analysis = blk: { //this block of code is telling us to exit our of the code based on the tea and coffe votes
        //the break here allows exit out of the code based on the votes of tea and coffee and return a value
        if (tea_vote > coffee_vote) break :blk "sane";
        if (tea_vote == coffee_vote) break :blk "whatever";
        if (tea_vote < coffee_vote) break :blk "dangerous";
    };

    //enums in zig
    std.debug.print("{any}\n", .{personality_analysis});
    const Status = enum {
        validate,
        awaiting_confirmation,
        confirmed,
        err,
    };
    std.debug.print("{any}\n", .{Status.validate}); //this is printing out the full qualified name of the enum value
    std.debug.print("{s}\n", .{@tagName(Status.validate)}); //@tagName reutrns the name of the enum value as a string

    const Stage = enum {
        validate,
        awaiting_confirmation,
        confirmed,
        err,

        fn isComplete(self: @This()) bool {
            return self == .confirmed or self == .err;
        }
    };
    std.debug.print("{any}\n", .{Stage.isComplete(.awaiting_confirmation)});

    //unions in zig
    const Number = union { //making a union which can handle several different types however only 1 can be active any any given time
        int: i64,
        float: f64,
        nan: void,
    };
    const n = Number{ .int = 32 }; //since this is a bare union since we do not have a tag to tell us which field is active
    std.debug.print("{d}\n", .{n.int});

    //tagged unions
    const Tag = enum {
        Int,
        String,
        Float,
    };
    const TaggedValidInput = union(Tag) {
        Int: i32,
        String: []const u8,
        Float: f32,
    };
}

//this funtcion works by you putting in a number so that we can have the
//the switch operator takes in a tuple and this can handle more than 1 variable specify our cases here

fn anniversaryName(years_married: u16) []const u8 {
    switch (years_married) {
        1 => return "paper",
        2 => return "cotton",
        3 => return "leather",
        4 => return "flower",
        5 => return "wood",
        6 => return "sugar",
        else => return "no more gifts for you",
    }
}

//this function is taking an ingeger parameter and returning the ascii value based on somne of the logic in our functions
//zig forces you to state the variable type for parameters as well as the the type your function is returning
fn arrivalTimeDesc(minutes: u16, is_late: bool) []const u8 {
    switch (minutes) {
        0 => return "arrived",
        1, 2 => return "soon",
        3...5 => return "no more than 5 minutes", //... indicates the range
        else => {
            if (!is_late) {
                return "sorry it'll be a while";
            }
            // todo, something is very wrong
            return "never";
        },
    }
}

fn contains(haystack: []const u32, needle: u32) bool {
    for (haystack) |value| {
        if (needle == value) {
            return true;
        }
    }
    return false;
}

//this function works by taking two arrays and checking if there individual elements are equal
//comptime means we are declaing the type at compile time
pub fn eql(comptime T: type, a: []const T, b: []const T) bool {
    if (a.len != b.len) return false;

    for (a, b) |a_elem, b_elem| {
        if (a_elem != b_elem) return false;
    }
    return true;
}

//this function takes a list and checks if there is a number if in array equals the haystack if so we return its index value
fn indexOf(haystack: []const u32, needle: u32) ?usize {
    for (haystack, 0..) |value, i| {
        if (needle == value) {
            return i;
        }
    }
    return null;
}
