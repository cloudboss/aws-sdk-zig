const RegisteredUserDashboardEmbeddingConfiguration = @import("registered_user_dashboard_embedding_configuration.zig").RegisteredUserDashboardEmbeddingConfiguration;
const RegisteredUserDashboardVisualEmbeddingConfiguration = @import("registered_user_dashboard_visual_embedding_configuration.zig").RegisteredUserDashboardVisualEmbeddingConfiguration;
const RegisteredUserGenerativeQnAEmbeddingConfiguration = @import("registered_user_generative_qn_a_embedding_configuration.zig").RegisteredUserGenerativeQnAEmbeddingConfiguration;
const RegisteredUserQSearchBarEmbeddingConfiguration = @import("registered_user_q_search_bar_embedding_configuration.zig").RegisteredUserQSearchBarEmbeddingConfiguration;
const RegisteredUserQuickChatEmbeddingConfiguration = @import("registered_user_quick_chat_embedding_configuration.zig").RegisteredUserQuickChatEmbeddingConfiguration;
const RegisteredUserQuickSightConsoleEmbeddingConfiguration = @import("registered_user_quick_sight_console_embedding_configuration.zig").RegisteredUserQuickSightConsoleEmbeddingConfiguration;

/// The type of experience you want to embed. For registered users, you can
/// embed Quick Suite dashboards or the Amazon Quick Sight console.
///
/// Exactly one of the experience configurations is required. You can choose
/// `Dashboard` or `QuickSightConsole`. You cannot choose more
/// than one experience configuration.
pub const RegisteredUserEmbeddingExperienceConfiguration = struct {
    /// The configuration details for providing a dashboard embedding experience.
    dashboard: ?RegisteredUserDashboardEmbeddingConfiguration,

    /// The type of embedding experience. In this case, Amazon Quick Sight visuals.
    dashboard_visual: ?RegisteredUserDashboardVisualEmbeddingConfiguration,

    /// The configuration details for embedding the Generative Q&A experience.
    ///
    /// For more information about embedding the Generative Q&A experience, see
    /// [Embedding
    /// Overview](https://docs.aws.amazon.com/quicksight/latest/user/embedding-overview.html) in
    /// the *Amazon Quick Sight User Guide*.
    generative_qn_a: ?RegisteredUserGenerativeQnAEmbeddingConfiguration,

    /// The configuration details for embedding the Q search bar.
    ///
    /// For more information about embedding the Q search bar, see [Embedding
    /// Overview](https://docs.aws.amazon.com/quicksight/latest/user/embedding-overview.html) in
    /// the *Amazon Quick Sight User Guide*.
    q_search_bar: ?RegisteredUserQSearchBarEmbeddingConfiguration,

    /// The configuration details for embedding the Quick chat agent.
    quick_chat: ?RegisteredUserQuickChatEmbeddingConfiguration,

    /// The configuration details for providing each Amazon Quick Sight console
    /// embedding
    /// experience. This can be used along with custom permissions to restrict
    /// access to certain
    /// features. For more information, see [Customizing Access to the Amazon Quick
    /// Sight
    /// Console](https://docs.aws.amazon.com/quicksight/latest/user/customizing-permissions-to-the-quicksight-console.html) in the
    /// *Amazon Quick Suite User Guide*.
    ///
    /// Use `
    /// [GenerateEmbedUrlForRegisteredUser](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_GenerateEmbedUrlForRegisteredUser.html)
    /// ` where you want to provide an
    /// authoring portal that allows users to create data sources, datasets,
    /// analyses, and
    /// dashboards. The users who accesses an embedded Amazon Quick Sight console
    /// needs to belong
    /// to the author or admin security cohort. If you want to restrict permissions
    /// to some of
    /// these features, add a custom permissions profile to the user with the `
    /// [UpdateUser](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_UpdateUser.html)
    /// ` API operation. Use the `
    /// [RegisterUser](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_RegisterUser.html)
    /// ` API operation to add a new user with a custom
    /// permission profile attached. For more information, see the following
    /// sections in the
    /// *Amazon Quick Suite User Guide*:
    ///
    /// * [Embedding the Full Functionality of the Amazon Quick Sight Console for
    /// Authenticated
    /// Users](https://docs.aws.amazon.com/quicksight/latest/user/embedded-analytics-full-console-for-authenticated-users.html)
    ///
    /// * [Customizing Access to the Amazon Quick Suite
    ///   Console](https://docs.aws.amazon.com/quicksight/latest/user/customizing-permissions-to-the-quicksight-console.html)
    ///
    /// For more information about the high-level steps for embedding and for an
    /// interactive
    /// demo of the ways you can customize embedding, visit the [Amazon Quick Suite
    /// Developer
    /// Portal](https://docs.aws.amazon.com/quicksight/latest/user/quicksight-dev-portal.html).
    quick_sight_console: ?RegisteredUserQuickSightConsoleEmbeddingConfiguration,

    pub const json_field_names = .{
        .dashboard = "Dashboard",
        .dashboard_visual = "DashboardVisual",
        .generative_qn_a = "GenerativeQnA",
        .q_search_bar = "QSearchBar",
        .quick_chat = "QuickChat",
        .quick_sight_console = "QuickSightConsole",
    };
};
