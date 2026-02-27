/// List of limits that are specific to a given InstanceType and for each of
/// it's
/// `
/// InstanceRole
/// `
/// .
pub const AdditionalLimit = struct {
    /// Name of Additional Limit is specific to a given InstanceType and for each of
    /// it's
    /// `
    /// InstanceRole
    /// `
    /// etc.
    ///
    /// Attributes and their details:
    ///
    /// * MaximumNumberOfDataNodesSupported
    /// This attribute will be present in Master node only to specify how
    /// much data nodes upto which given
    /// `
    /// ESPartitionInstanceType
    /// `
    /// can support as master node.
    ///
    /// * MaximumNumberOfDataNodesWithoutMasterNode
    /// This attribute will be present in Data node only to specify how much
    /// data nodes of given
    /// `
    /// ESPartitionInstanceType
    /// `
    /// upto which you don't need any master nodes to govern them.
    limit_name: ?[]const u8,

    /// Value for given
    /// `
    /// AdditionalLimit$LimitName
    /// `
    /// .
    limit_values: ?[]const []const u8,

    pub const json_field_names = .{
        .limit_name = "LimitName",
        .limit_values = "LimitValues",
    };
};
