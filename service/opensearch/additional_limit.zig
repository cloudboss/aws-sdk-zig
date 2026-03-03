/// List of limits that are specific to a given instance type.
pub const AdditionalLimit = struct {
    /// * `MaximumNumberOfDataNodesSupported` - This attribute only applies
    /// to master nodes and specifies the maximum number of data nodes of a given
    /// instance type a master node can support.
    ///
    /// * `MaximumNumberOfDataNodesWithoutMasterNode` - This attribute only
    /// applies to data nodes and specifies the maximum number of data nodes of a
    /// given
    /// instance type can exist without a master node governing them.
    limit_name: ?[]const u8 = null,

    /// The values of the additional instance type limits.
    limit_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .limit_name = "LimitName",
        .limit_values = "LimitValues",
    };
};
