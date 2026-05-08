const CompositeSliComponent = @import("composite_sli_component.zig").CompositeSliComponent;
const SelectionConfig = @import("selection_config.zig").SelectionConfig;

/// This structure contains the configuration for a composite service level
/// indicator (SLI) that aggregates metrics across multiple operations of a
/// service for service-level SLOs.
pub const CompositeSliConfig = struct {
    /// The list of operations included in this composite SLI. You must specify
    /// between 2 and 20 components. Each component is a `CompositeSliComponent`
    /// that identifies a single operation by its `OperationName`.
    components: ?[]const CompositeSliComponent = null,

    /// Specifies how operations are selected for this service-level SLO. Operations
    /// can be selected explicitly by listing them, by specifying a prefix to match
    /// operation names, or by providing a regular expression pattern.
    selection_config: SelectionConfig,

    pub const json_field_names = .{
        .components = "Components",
        .selection_config = "SelectionConfig",
    };
};
