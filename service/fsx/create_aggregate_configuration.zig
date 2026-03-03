/// Used to specify the configuration options for an FSx for ONTAP volume's
/// storage aggregate or aggregates.
pub const CreateAggregateConfiguration = struct {
    /// Used to specify the names of aggregates on which the volume will be created.
    aggregates: ?[]const []const u8 = null,

    /// Used to explicitly set the number of constituents within the FlexGroup per
    /// storage aggregate. This field is optional when creating a FlexGroup volume.
    /// If unspecified, the default value will be 8. This field cannot be provided
    /// when creating a FlexVol volume.
    constituents_per_aggregate: ?i32 = null,

    pub const json_field_names = .{
        .aggregates = "Aggregates",
        .constituents_per_aggregate = "ConstituentsPerAggregate",
    };
};
