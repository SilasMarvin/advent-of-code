const std = @import("std");
const fs = std.fs;

pub fn main() !void {
    var input: [10518]u8 = undefined;

    const dir = fs.cwd();
    const open_flags = fs.File.OpenFlags{};
    const f = try dir.openFile("input", open_flags);
    // We know the size of this is 10518
    _ = try f.readAll(&input);

    var max: usize = 0;
    var current_sum: usize = 0;
    var last_byte: u8 = 0;
    var current_num: usize = 0;
    for (input) |byte| {
        if (byte == '\n') {
            if (last_byte == '\n') {
                if (current_sum > max) {
                    max = current_sum;
                }
                current_sum = 0;
            }
            current_sum += current_num;
            current_num = 0;
        } else {
            current_num *= 10;
            current_num += byte - 48;
        }
        last_byte = byte;
    }

    std.debug.print("Answer: {}", .{max});
}
