const std = @import("std"); // importing the standard library
const User = @import("models/users.zig").User; //importing User "class" from the models folder
const print = @import("std").debug.print;

pub fn main() !void {
    std.debug.print("Hello World\n", .{});
    //{s}{s} is telling us the data type that we need to specify from the parameters and the second set of {}
    //we still need to send parameter places even if do not have any parameters in place the second set of {} should be empty

    const user = User{ //calling the struct from models.users
        .power = 9001,
        .name = "Goku", //"Goku" takes on the example of {'G', 'o','k','u',0} and its type is *const[4:0] u8
        //if a function or structure has a []const u8 string literals can be used because null terminated strings are arrays and arrays have known length
    };
    std.debug.print("{s}'s power is {d}\n", .{ user.name, user.power });

    const sum = add(8999, 2);
    std.debug.print("8999 + 2 = {d}\n", .{sum}); //doing some basic cacluclations and calling the constant sum and calling the function add

    user.diagnose();

    //Arrays and slicing
    var a = [_]i32{ 1, 2, 3, 4, 5 }; // declaring the length of the array and the identifier will figure the length for us
    var end: usize = 3; //create variable with "usize" which allows us to make sure that we have a non-negative integer
    end += 1;
    const b = a[1..end]; //where we are indexing the array
    std.debug.print("{d}\n", .{a});
    std.debug.print("{d}\n", .{b});
    std.debug.print("{any}\n", .{@TypeOf(b)});

    //weird example
    const c = [3:false]bool{ false, true, false }; //the [] follows the order of 'length' and 'sentinel' which is a special way of ending the array
    //so const c is making an array of length 3 that contains the values of [false, true, false]
    std.debug.print("{any}\n", .{std.mem.asBytes(&c).*}); //we print the values of as bytes for binary values notice that 0 at he end

    std.debug.print("{any}\n", .{@TypeOf(.{ .year = 2023, .month = 8 })});
    //the reason this code is able to work is that zig

    const super = if (user.power > 9000) true else false;
    std.debug.print("{any}\n", .{super});

    const re: i8 = 64;
    const rs: i8 = 45;
    const res: i8 = re + rs;

    std.debug.print("the sum of the numbers are {d}\n", .{res});
    // showUnions();

    // showEnums();

    // showingStructs();
}

fn add(a: i64, b: i64) i64 {
    return a + b;
}

// //unions
// const Number = union(enum) { small: u8, medium: u16, large: u32 };

// fn GetUnion() Number {
//     const number_union = Number{ .small = 10 };
//     return number_union;
// }

// fn showUnions() void {
//     var number = Number{ .small = 200 };
//     print("number = {}\n", .{number.small});
//     print("number small = type: {}\n", .{@TypeOf(number.small)});
//     number.small -= 10;

//     number = Number{ .medium = 1000 };
//     print("number = {}\n", .{number.medium});
//     print("number medium = type: {}\n", .{@TypeOf(number.medium)}); // now we changed number and its attribute of medium to 1000 we now have the medium type become a u16

//     number = Number{ .large = 40000 };
//     print("number = {}\n", .{number.large});
//     print("number large type = type: {}\n", .{@TypeOf(number.large)});

//     // print("\n\n\n,.{}");
// }

// //enums
// const Squares = enum { a8, b8, c8, d8, e8, f8, g8, h8, a7, b7, c7, d7, e7, f7, g7, h7, a6, b6, c6, d6, e6, f6, g6, h6, a5, b5, c5, d5, e5, f5, g5, h5, a4, b4, c4, d4, e4, f4, g4, h4, a3, b3, c3, d3, e3, f3, g3, h3, a2, b2, c2, d2, e2, f2, g2, h2, a1, b1, c1, d1, e1, f1, g1, h1, invalid };

// const Pieces = enum {
//     empty,
//     wk,
// };

// fn showEnums() void {
//     var array = [64]u8{
//         0, 0, 0, 0, 0, 0, 0, 0,
//         0, 0, 0, 0, 0, 0, 0, 0,
//         0, 0, 0, 0, 0, 0, 0, 0,
//         0, 0, 0, 0, 0, 0, 0, 0,
//         0, 0, 0, 0, 0, 0, 0, 0,
//         0, 0, 0, 0, 0, 0, 0, 0,
//         0, 0, 0, 0, 0, 0, 0, 0,
//         0, 0, 0, 0, 0, 0, 0, 0,
//     };
//     array[@intFromEnum(Squares.e1)] = @intFromEnum(Pieces.wk);
//     print("value at e1 = {}\n", .{array[@intFromEnum(Squares.e1)]});
//     print("type of enum: {}\n", .{@TypeOf(Squares.e1)});
//     const e1 = @intFromEnum(Squares.e1);
//     print("type of e1: {}, value{}\n", .{ @TypeOf(e1), e1 });
// }

// //structs
// const AddingError = error{ IntegerOverFlowHigh, IntegerOverFlowLow };
// const Math = struct {
//     const MAX_I32: i32 = 2147483647;
//     const MIN_I32: i32 = -214783648;

//     pub fn addI32(self: Math, a: i32, b: i32) AddingError!i32 {
//         _ = self;
//         var temp: i64 = a;
//         temp += b;
//         if (temp > MAX_I32) {
//             print("Error: integer overflow high\n", .{});
//             return AddingError.IntegerOverFlowHigh;
//         }
//         if (temp < MIN_I32) {
//             print("Error: integer overflow low\n", .{});
//             return AddingError.IntegerOverFlowLow;
//         }
//         return a + b;
//     }
//     pub fn PrintResult(self: Math, result: i32) void {
//         print("{} {}\n", .{ self, result });
//     }
// };

// const Gender = enum { male, female, other };

// const LoginError = error{
//     incorrect_username,
//     incorrect_password,
//     already_logged_in,
// };

// const LogoutError = error{
//     not_logged_in,
// };

// const USer = struct {
//     name: []const u8,
//     username: []const u8,
//     password: []const u8,
//     age: u8,
//     gender: Gender,
//     logged_in: bool = false,

//     fn login(self: *USer, inserted_username: []const u8, inserted_password: []const u8) LoginError!void {
//         if (self.logged_in == true) {
//             return LoginError.already_logged_in;
//         }
//         const username_length = self.username.len;
//         const inserted_username_length = inserted_username.len;
//         if (username_length != inserted_username_length) {
//             return LoginError.incorrect_username;
//         }

//         const password_length = self.password.len;
//         const inserted_password_length = inserted_password.len;
//         if (password_length != inserted_password_length) {
//             return LoginError.incorrect_password;
//         }
//         for (0..username_length) |index| {
//             if (self.username[index] == inserted_username[index]) {
//                 continue;
//             }
//             return LoginError.incorrect_username;
//         }
//         for (0..password_length) |index| {
//             if (self.password[index] == inserted_password[index]) {
//                 continue;
//             }
//             return LoginError.incorrect_password;
//         }

//         const login_result = login(self, inserted_username, inserted_password);
//         if (login_result) |_| {
//             self.logged_in = true;
//             print("Successfully logged in!\n", .{});
//         } else |err| {
//             print("Login ERROR: {}\n", .{err});
//         }
//     }
//     pub fn attempt_login(self: *USer, inserted_username: []const u8, inserted_password: []const u8) void {
//         const login_result = login(self, inserted_username, inserted_password);
//         if (login_result) |_| {
//             self.logged_in = true;
//             print("Sucessfully logged in!\n", .{});
//         } else |err| {
//             print("Login ERROR: {}\n", .{err});
//         }
//     }
// };

// fn showingStructs() void {
//     const math: Math = Math{};
//     const result = math.addI32(10, 10) catch 10;
//     math.PrintResult(result);

//     var user1: USer = USer{ .name = "Phil Jacobs", .username = "Phil-Jacobs", .password = "pj123", .gender = Gender.male, .age = 25 };

//     user1.attempt_login("Phil-Jacobs", "pj123");
//     print("\n", .{});
//     user1.attempt_login("Phil-Jacobs", "pj123");
//     print("\n", {});
// }
