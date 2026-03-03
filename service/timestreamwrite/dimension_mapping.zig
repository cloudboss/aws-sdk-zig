pub const DimensionMapping = struct {
    destination_column: ?[]const u8 = null,

    source_column: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_column = "DestinationColumn",
        .source_column = "SourceColumn",
    };
};
