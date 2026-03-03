const std = @import("std");

pub const ContentClassifier = enum {
    free_of_personally_identifiable_information,
    free_of_adult_content,

    pub const json_field_names = .{
        .free_of_personally_identifiable_information = "FreeOfPersonallyIdentifiableInformation",
        .free_of_adult_content = "FreeOfAdultContent",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .free_of_personally_identifiable_information => "FreeOfPersonallyIdentifiableInformation",
            .free_of_adult_content => "FreeOfAdultContent",
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
