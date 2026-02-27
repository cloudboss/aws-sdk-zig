const AnonymousUserDashboardEmbeddingConfiguration = @import("anonymous_user_dashboard_embedding_configuration.zig").AnonymousUserDashboardEmbeddingConfiguration;
const AnonymousUserDashboardVisualEmbeddingConfiguration = @import("anonymous_user_dashboard_visual_embedding_configuration.zig").AnonymousUserDashboardVisualEmbeddingConfiguration;
const AnonymousUserGenerativeQnAEmbeddingConfiguration = @import("anonymous_user_generative_qn_a_embedding_configuration.zig").AnonymousUserGenerativeQnAEmbeddingConfiguration;
const AnonymousUserQSearchBarEmbeddingConfiguration = @import("anonymous_user_q_search_bar_embedding_configuration.zig").AnonymousUserQSearchBarEmbeddingConfiguration;

/// The type of experience you want to embed. For anonymous users, you can embed
/// Quick Suite dashboards.
pub const AnonymousUserEmbeddingExperienceConfiguration = struct {
    /// The type of embedding experience. In this case, Amazon Quick Sight
    /// dashboards.
    dashboard: ?AnonymousUserDashboardEmbeddingConfiguration,

    /// The type of embedding experience. In this case, Amazon Quick Sight visuals.
    dashboard_visual: ?AnonymousUserDashboardVisualEmbeddingConfiguration,

    /// The Generative Q&A experience that you want to use for anonymous user
    /// embedding.
    generative_qn_a: ?AnonymousUserGenerativeQnAEmbeddingConfiguration,

    /// The Q search bar that you want to use for anonymous user embedding.
    q_search_bar: ?AnonymousUserQSearchBarEmbeddingConfiguration,

    pub const json_field_names = .{
        .dashboard = "Dashboard",
        .dashboard_visual = "DashboardVisual",
        .generative_qn_a = "GenerativeQnA",
        .q_search_bar = "QSearchBar",
    };
};
