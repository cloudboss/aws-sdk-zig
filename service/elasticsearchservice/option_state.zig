const std = @import("std");

/// The state of a requested change. One of the following:
///
/// * Processing: The request change is still in-process.
///
/// * Active: The request change is processed and deployed to the Elasticsearch
///   domain.
pub const OptionState = enum {
    requires_index_documents,
    processing,
    active,

    pub const json_field_names = .{
        .requires_index_documents = "RequiresIndexDocuments",
        .processing = "Processing",
        .active = "Active",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requires_index_documents => "RequiresIndexDocuments",
            .processing => "Processing",
            .active => "Active",
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
