/// The identifier that identifies the batch of Records you are retrieving in a
/// batch.
pub const BatchGetRecordIdentifier = struct {
    /// The name or Amazon Resource Name (ARN) of the `FeatureGroup` containing the
    /// records you are retrieving in a batch.
    feature_group_name: []const u8,

    /// List of names of Features to be retrieved. If not specified, the latest
    /// value for all
    /// the Features are returned.
    feature_names: ?[]const []const u8,

    /// The value for a list of record identifiers in string format.
    record_identifiers_value_as_string: []const []const u8,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .feature_names = "FeatureNames",
        .record_identifiers_value_as_string = "RecordIdentifiersValueAsString",
    };
};
