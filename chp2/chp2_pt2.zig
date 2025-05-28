const std = @import("std");
const print = @import("std").debug.print;

pub fn main() !void {
    const Employee = struct {
        name: []const u8, //const u8 is treated as a slice of bytes rather than a string
        id: u8,
        position: []const u8,
        salary: u16,

        const Self = @This(); //creates an alias that refers to the struct type itself

        pub fn printDetails(self: *const Self) void {
            print("Name: {s}\nId: {d}\nposition: {s}\nsalary: {d}\n", .{ self.name, self.id, self.position, self.salary });
        }
        pub fn calcbonus(self: *const Self) void {
            const janitor = [_]u8{ 'J', 'a', 'n', 'i', 't', 'o', 'r' }; //single '' are string literals
            const manager = [_]u8{ 'M', 'a', 'n', 'a', 'g', 'e', 'r' };

            const isjanitor = std.mem.eql(u8, self.position, &janitor); //self is already a slice and does not need the & for the address
            const ismanager = std.mem.eql(u8, self.position, &manager);

            if (isjanitor) {
                const sal_convert: f32 = @floatFromInt(self.salary);
                const bonus: f32 = sal_convert * 0.1;
                print("Your bonus is {d}\n", .{bonus});
            } else if (ismanager) {
                const bonus = self.salary * 2;
                print("Your bonus is {b}\n", .{bonus});
            } else {
                print("Your bonus us is 0", .{});
            }
        }
        pub fn compareSalary(self: *const Self, other_employee: *const Self) void {
            if (self.salary > other_employee.salary) {
                print("{s} has the higher salary at {d}\n", .{ self.name, self.salary });
            } else {
                print("{s} has the higher salary at {d}\n", .{ other_employee.name, other_employee.salary });
            }
        }
    };
    const employee1 = Employee{ .name = "Jim", .id = 1, .position = "Janitor", .salary = 200 };
    employee1.printDetails();
    employee1.calcbonus();

    const employee2 = Employee{ .name = "Bob", .id = 1, .position = "Manager", .salary = 300 };
    employee1.compareSalary(&employee2); //& creates a pointer by taking its memory address and pointing to the value
}

//you dont need to destroy pointers if they are on the stack
//we dont need a heap allocator because there is no memory to free
//not everything can be on the stack 