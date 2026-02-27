const PrivacyBudgetTemplateAutoRefresh = @import("privacy_budget_template_auto_refresh.zig").PrivacyBudgetTemplateAutoRefresh;
const PrivacyBudgetTemplateParametersOutput = @import("privacy_budget_template_parameters_output.zig").PrivacyBudgetTemplateParametersOutput;
const PrivacyBudgetType = @import("privacy_budget_type.zig").PrivacyBudgetType;

/// An object that defines the privacy budget template.
pub const PrivacyBudgetTemplate = struct {
    /// The ARN of the privacy budget template.
    arn: []const u8,

    /// How often the privacy budget refreshes.
    ///
    /// If you plan to regularly bring new data into the collaboration, use
    /// `CALENDAR_MONTH` to automatically get a new privacy budget for the
    /// collaboration every calendar month. Choosing this option allows arbitrary
    /// amounts of information to be revealed about rows of the data when repeatedly
    /// queried across refreshes. Avoid choosing this if the same rows will be
    /// repeatedly queried between privacy budget refreshes.
    auto_refresh: PrivacyBudgetTemplateAutoRefresh,

    /// The ARN of the collaboration that contains this privacy budget template.
    collaboration_arn: []const u8,

    /// The unique ID of the collaboration that contains this privacy budget
    /// template.
    collaboration_id: []const u8,

    /// The time at which the privacy budget template was created.
    create_time: i64,

    /// The unique identifier of the privacy budget template.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the member who created the privacy budget
    /// template.
    membership_arn: []const u8,

    /// The identifier for a membership resource.
    membership_id: []const u8,

    /// Specifies the epsilon and noise parameters for the privacy budget template.
    parameters: PrivacyBudgetTemplateParametersOutput,

    /// Specifies the type of the privacy budget template.
    privacy_budget_type: PrivacyBudgetType,

    /// The most recent time at which the privacy budget template was updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .auto_refresh = "autoRefresh",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .parameters = "parameters",
        .privacy_budget_type = "privacyBudgetType",
        .update_time = "updateTime",
    };
};
