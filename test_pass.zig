const std = @import("std");

const expect = std.testing.expect;

fn squareInt(number: i16) i16 {
    return number * number;
}

test squareInt {
    try std.testing.expect(squareInt(13) == 169);
}

test "always succeeds" {
    try expect(true);
}
