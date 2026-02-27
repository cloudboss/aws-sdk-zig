const DashboardVisualId = @import("dashboard_visual_id.zig").DashboardVisualId;

/// The experience that you are embedding. You can use this object to generate a
/// url that
/// embeds a visual into your application.
pub const AnonymousUserDashboardVisualEmbeddingConfiguration = struct {
    /// The visual ID for the visual that you want the user to see. This ID is
    /// included in the
    /// output URL. When the URL in response is accessed, Amazon Quick Sight renders
    /// this
    /// visual.
    ///
    /// The Amazon Resource Name (ARN) of the dashboard that the visual belongs to
    /// must be
    /// included in the `AuthorizedResourceArns` parameter. Otherwise, the request
    /// will fail with `InvalidParameterValueException`.
    initial_dashboard_visual_id: DashboardVisualId,

    pub const json_field_names = .{
        .initial_dashboard_visual_id = "InitialDashboardVisualId",
    };
};
