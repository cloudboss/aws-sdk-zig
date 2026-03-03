const std = @import("std");

pub const X12FunctionalAcknowledgment = enum {
    do_not_generate,
    generate_all_segments,
    generate_without_transaction_set_response_loop,

    pub const json_field_names = .{
        .do_not_generate = "DO_NOT_GENERATE",
        .generate_all_segments = "GENERATE_ALL_SEGMENTS",
        .generate_without_transaction_set_response_loop = "GENERATE_WITHOUT_TRANSACTION_SET_RESPONSE_LOOP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .do_not_generate => "DO_NOT_GENERATE",
            .generate_all_segments => "GENERATE_ALL_SEGMENTS",
            .generate_without_transaction_set_response_loop => "GENERATE_WITHOUT_TRANSACTION_SET_RESPONSE_LOOP",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
