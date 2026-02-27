pub const DimensionMapping = struct {
    destination_column: ?[]const u8,

    source_column: ?[]const u8,

    pub const json_field_names = .{
        .destination_column = "DestinationColumn",
        .source_column = "SourceColumn",
    };
};
