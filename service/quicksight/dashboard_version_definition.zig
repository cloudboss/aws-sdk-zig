const AnalysisDefaults = @import("analysis_defaults.zig").AnalysisDefaults;
const CalculatedField = @import("calculated_field.zig").CalculatedField;
const ColumnConfiguration = @import("column_configuration.zig").ColumnConfiguration;
const DataSetIdentifierDeclaration = @import("data_set_identifier_declaration.zig").DataSetIdentifierDeclaration;
const FilterGroup = @import("filter_group.zig").FilterGroup;
const AssetOptions = @import("asset_options.zig").AssetOptions;
const ParameterDeclaration = @import("parameter_declaration.zig").ParameterDeclaration;
const SheetDefinition = @import("sheet_definition.zig").SheetDefinition;
const StaticFile = @import("static_file.zig").StaticFile;

/// The contents of a dashboard.
pub const DashboardVersionDefinition = struct {
    analysis_defaults: ?AnalysisDefaults = null,

    /// An array of calculated field definitions for the dashboard.
    calculated_fields: ?[]const CalculatedField = null,

    /// An array of dashboard-level column configurations. Column configurations
    /// are used to set the default formatting for a column that
    /// is used throughout a dashboard.
    column_configurations: ?[]const ColumnConfiguration = null,

    /// An array of dataset identifier declarations. With
    /// this mapping,you can use dataset identifiers instead of dataset Amazon
    /// Resource Names (ARNs) throughout the dashboard's sub-structures.
    data_set_identifier_declarations: []const DataSetIdentifierDeclaration,

    /// The filter definitions for a dashboard.
    ///
    /// For more information, see [Filtering Data in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/adding-a-filter.html) in the *Amazon Quick Suite User Guide*.
    filter_groups: ?[]const FilterGroup = null,

    /// An array of option definitions for a dashboard.
    options: ?AssetOptions = null,

    /// The parameter declarations for a dashboard. Parameters are named variables
    /// that can transfer a value for use by an action or an object.
    ///
    /// For more information, see [Parameters in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/parameters-in-quicksight.html) in the *Amazon Quick Suite User Guide*.
    parameter_declarations: ?[]const ParameterDeclaration = null,

    /// An array of sheet definitions for a dashboard.
    sheets: ?[]const SheetDefinition = null,

    /// The static files for the definition.
    static_files: ?[]const StaticFile = null,

    pub const json_field_names = .{
        .analysis_defaults = "AnalysisDefaults",
        .calculated_fields = "CalculatedFields",
        .column_configurations = "ColumnConfigurations",
        .data_set_identifier_declarations = "DataSetIdentifierDeclarations",
        .filter_groups = "FilterGroups",
        .options = "Options",
        .parameter_declarations = "ParameterDeclarations",
        .sheets = "Sheets",
        .static_files = "StaticFiles",
    };
};
