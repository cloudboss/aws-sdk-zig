const AppUnitErrorCategory = @import("app_unit_error_category.zig").AppUnitErrorCategory;

/// Error in the analysis of the application unit.
pub const AppUnitError = struct {
    /// The category of the error.
    app_unit_error_category: ?AppUnitErrorCategory,

    pub const json_field_names = .{
        .app_unit_error_category = "appUnitErrorCategory",
    };
};
