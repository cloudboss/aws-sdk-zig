const LayoutConfiguration = @import("layout_configuration.zig").LayoutConfiguration;

/// A `Layout` defines the placement of elements within a sheet.
///
/// For more information, see [Types of
/// layout](https://docs.aws.amazon.com/quicksight/latest/user/types-of-layout.html) in the *Amazon Quick Suite User Guide*.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const Layout = struct {
    /// The configuration that determines what the type of layout for a sheet.
    configuration: LayoutConfiguration,

    pub const json_field_names = .{
        .configuration = "Configuration",
    };
};
