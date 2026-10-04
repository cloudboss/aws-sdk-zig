const std = @import("std");

/// Choose `CUSTOM` to provide your own Bedrock embedding model ARN. Choose
/// `MANAGED` to use a service-managed embedding model. For more information,
/// see [Embedding model
/// options](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-managed-create.html#kb-managed-embedding-models).
pub const EmbeddingModelType = enum {
    custom,
    managed,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .managed = "MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom => "CUSTOM",
            .managed => "MANAGED",
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
