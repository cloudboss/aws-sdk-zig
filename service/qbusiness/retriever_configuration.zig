const KendraIndexConfiguration = @import("kendra_index_configuration.zig").KendraIndexConfiguration;
const NativeIndexConfiguration = @import("native_index_configuration.zig").NativeIndexConfiguration;

/// Provides information on how the retriever used for your Amazon Q Business
/// application is configured.
pub const RetrieverConfiguration = union(enum) {
    /// Provides information on how the Amazon Kendra index used as a retriever for
    /// your Amazon Q Business application is configured.
    kendra_index_configuration: ?KendraIndexConfiguration,
    /// Provides information on how a Amazon Q Business index used as a retriever
    /// for your Amazon Q Business application is configured.
    native_index_configuration: ?NativeIndexConfiguration,

    pub const json_field_names = .{
        .kendra_index_configuration = "kendraIndexConfiguration",
        .native_index_configuration = "nativeIndexConfiguration",
    };
};
