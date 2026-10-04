const std = @import("std");

pub const QueryTokenStandard = enum {
    erc20,
    erc721,
    erc1155,

    pub const json_field_names = .{
        .erc20 = "ERC20",
        .erc721 = "ERC721",
        .erc1155 = "ERC1155",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .erc20 => "ERC20",
            .erc721 => "ERC721",
            .erc1155 => "ERC1155",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
