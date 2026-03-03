const std = @import("std");

pub const HubContentType = enum {
    model,
    notebook,
    model_reference,
    data_set,
    json_doc,

    pub const json_field_names = .{
        .model = "Model",
        .notebook = "Notebook",
        .model_reference = "ModelReference",
        .data_set = "DataSet",
        .json_doc = "JsonDoc",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .model => "Model",
            .notebook => "Notebook",
            .model_reference => "ModelReference",
            .data_set => "DataSet",
            .json_doc => "JsonDoc",
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
