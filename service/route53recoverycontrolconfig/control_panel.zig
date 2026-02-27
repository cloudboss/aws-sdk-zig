const Status = @import("status.zig").Status;

/// A control panel represents a group of routing controls that can be changed
/// together in a single transaction.
pub const ControlPanel = struct {
    /// The Amazon Resource Name (ARN) of the cluster that includes the control
    /// panel.
    cluster_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the control panel.
    control_panel_arn: ?[]const u8,

    /// A flag that Amazon Route 53 Application Recovery Controller sets to true to
    /// designate the default control panel for a cluster. When you create a
    /// cluster, Amazon Route 53 Application Recovery Controller creates a control
    /// panel, and sets this flag for that control panel. If you create a control
    /// panel yourself, this flag is set to false.
    default_control_panel: ?bool,

    /// The name of the control panel. You can use any non-white space character in
    /// the name.
    name: ?[]const u8,

    /// The Amazon Web Services account ID of the control panel owner.
    owner: ?[]const u8,

    /// The number of routing controls in the control panel.
    routing_control_count: ?i32,

    /// The deployment status of control panel. Status can be one of the following:
    /// PENDING, DEPLOYED, PENDING_DELETION.
    status: ?Status,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .control_panel_arn = "ControlPanelArn",
        .default_control_panel = "DefaultControlPanel",
        .name = "Name",
        .owner = "Owner",
        .routing_control_count = "RoutingControlCount",
        .status = "Status",
    };
};
