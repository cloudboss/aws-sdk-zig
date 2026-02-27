const FormDataTypeConfig = @import("form_data_type_config.zig").FormDataTypeConfig;
const FormActionType = @import("form_action_type.zig").FormActionType;

/// Describes the basic information about a form.
pub const FormSummary = struct {
    /// The unique ID for the app associated with the form summary.
    app_id: []const u8,

    /// The form's data source type.
    data_type: FormDataTypeConfig,

    /// The name of the backend environment that is part of the Amplify app.
    environment_name: []const u8,

    /// The type of operation to perform on the form.
    form_action_type: FormActionType,

    /// The ID of the form.
    id: []const u8,

    /// The name of the form.
    name: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .data_type = "dataType",
        .environment_name = "environmentName",
        .form_action_type = "formActionType",
        .id = "id",
        .name = "name",
    };
};
