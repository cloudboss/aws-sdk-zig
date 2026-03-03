const SolutionStatus = @import("solution_status.zig").SolutionStatus;

/// Specifies minimal information for the solution offered to solve the
/// customer's business problem.
pub const SolutionBase = struct {
    /// The SolutionBase structure provides essential information about a solution.
    arn: ?[]const u8 = null,

    /// Specifies the catalog in which the solution is hosted, either `AWS` or
    /// `Sandbox`. This helps partners differentiate between live solutions and
    /// those in testing environments.
    catalog: []const u8,

    /// Specifies the solution category, which helps to categorize and organize the
    /// solutions partners offer. Valid values: `Software Product` | `Consulting
    /// Service` | `Hardware Product` | `Communications Product` | `Professional
    /// Service` | `Managed Service` | `Value-Added Resale Amazon Web Services
    /// Service` | `Distribution Service` | `Training Service` | `Merger and
    /// Acquisition Advising Service`.
    category: []const u8,

    /// Indicates the solution creation date. This is useful to track and audit.
    created_date: i64,

    /// Enables the association of solutions (offerings) to opportunities.
    id: []const u8,

    /// Specifies the solution name.
    name: []const u8,

    /// Specifies the solution's current status, which indicates its state in the
    /// system. Valid values: `Active` | `Inactive` | `Draft`. The status helps
    /// partners and Amazon Web Services track the solution's lifecycle and
    /// availability. Filter for `Active` solutions for association to an
    /// opportunity.
    status: SolutionStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .category = "Category",
        .created_date = "CreatedDate",
        .id = "Id",
        .name = "Name",
        .status = "Status",
    };
};
