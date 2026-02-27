/// Used to select which agent's data is to be exported. A single agent ID may
/// be selected
/// for export using the
/// [StartExportTask](http://docs.aws.amazon.com/application-discovery/latest/APIReference/API_StartExportTask.html) action.
pub const ExportFilter = struct {
    /// Supported condition: `EQUALS`
    condition: []const u8,

    /// A single `ExportFilter` name. Supported filters:
    /// `agentIds`.
    name: []const u8,

    /// A single agent ID for a Discovery Agent. An agent ID can be found using the
    /// [DescribeAgents](http://docs.aws.amazon.com/application-discovery/latest/APIReference/API_DescribeAgents.html) action. Typically an ADS agent ID is in the form
    /// `o-0123456789abcdef0`.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .name = "name",
        .values = "values",
    };
};
