/// Contains the name and values of a manual Amazon Relational Database Service
/// (RDS) DB cluster snapshot attribute.
pub const AwsRdsDbClusterSnapshotDbClusterSnapshotAttribute = struct {
    /// The name of the manual DB cluster snapshot attribute. The attribute named
    /// `restore` refers to the list of
    /// Amazon Web Services accounts that have permission to copy or restore the
    /// manual DB cluster snapshot.
    attribute_name: ?[]const u8 = null,

    /// The value(s) for the manual DB cluster snapshot attribute. If the
    /// `AttributeName` field is set to
    /// `restore`, then this element returns a list of IDs of the Amazon Web
    /// Services accounts that are authorized
    /// to copy or restore the manual DB cluster snapshot. If a value of `all` is in
    /// the list, then the manual
    /// DB cluster snapshot is public and available for any Amazon Web Services
    /// account to copy or restore.
    attribute_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_values = "AttributeValues",
    };
};
