const AutomaticInputFailoverSettings = @import("automatic_input_failover_settings.zig").AutomaticInputFailoverSettings;
const InputSettings = @import("input_settings.zig").InputSettings;

/// Placeholder documentation for InputAttachment
pub const InputAttachment = struct {
    /// User-specified settings for defining what the conditions are for declaring
    /// the input unhealthy and failing over to a different input.
    automatic_input_failover_settings: ?AutomaticInputFailoverSettings = null,

    /// User-specified name for the attachment. This is required if the user wants
    /// to use this input in an input switch action.
    input_attachment_name: ?[]const u8 = null,

    /// The ID of the input
    input_id: ?[]const u8 = null,

    /// Settings of an input (caption selector, etc.)
    input_settings: ?InputSettings = null,

    /// Optional assignment of an input to a logical interface on the Node. Only
    /// applies to on premises channels.
    logical_interface_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .automatic_input_failover_settings = "AutomaticInputFailoverSettings",
        .input_attachment_name = "InputAttachmentName",
        .input_id = "InputId",
        .input_settings = "InputSettings",
        .logical_interface_names = "LogicalInterfaceNames",
    };
};
