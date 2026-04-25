const AnalysisDefaults = @import("analysis_defaults.zig").AnalysisDefaults;
const CalculatedField = @import("calculated_field.zig").CalculatedField;
const ColumnConfiguration = @import("column_configuration.zig").ColumnConfiguration;
const DataSetIdentifierDeclaration = @import("data_set_identifier_declaration.zig").DataSetIdentifierDeclaration;
const FilterGroup = @import("filter_group.zig").FilterGroup;
const AssetOptions = @import("asset_options.zig").AssetOptions;
const ParameterDeclaration = @import("parameter_declaration.zig").ParameterDeclaration;
const QueryExecutionOptions = @import("query_execution_options.zig").QueryExecutionOptions;
const SheetDefinition = @import("sheet_definition.zig").SheetDefinition;
const StaticFile = @import("static_file.zig").StaticFile;
const TooltipSheetDefinition = @import("tooltip_sheet_definition.zig").TooltipSheetDefinition;

/// The definition of an analysis.
pub const AnalysisDefinition = struct {
    analysis_defaults: ?AnalysisDefaults = null,

    /// An array of calculated field definitions for the analysis.
    calculated_fields: ?[]const CalculatedField = null,

    /// An array of analysis-level column configurations. Column configurations can
    /// be used to set default
    /// formatting for a column to be used throughout an analysis.
    column_configurations: ?[]const ColumnConfiguration = null,

    /// An array of dataset identifier declarations. This mapping allows the usage
    /// of dataset identifiers instead
    /// of dataset ARNs throughout analysis sub-structures.
    data_set_identifier_declarations: []const DataSetIdentifierDeclaration,

    /// Filter definitions for an analysis.
    ///
    /// For more information, see [Filtering Data in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/adding-a-filter.html) in the *Amazon Quick Suite User Guide*.
    filter_groups: ?[]const FilterGroup = null,

    /// An array of option definitions for an analysis.
    options: ?AssetOptions = null,

    /// An array of parameter declarations for an analysis.
    ///
    /// Parameters are named variables that can transfer a value for use by an
    /// action or an object.
    ///
    /// For more information, see [Parameters in Amazon Quick
    /// Sight](https://docs.aws.amazon.com/quicksight/latest/user/parameters-in-quicksight.html) in the *Amazon Quick Suite User Guide*.
    parameter_declarations: ?[]const ParameterDeclaration = null,

    query_execution_options: ?QueryExecutionOptions = null,

    /// An array of sheet definitions for an analysis. Each `SheetDefinition`
    /// provides detailed information about
    /// a sheet within this analysis.
    sheets: ?[]const SheetDefinition = null,

    /// The static files for the definition.
    static_files: ?[]const StaticFile = null,

    /// An array of tooltip sheet definitions for an analysis. Each
    /// `TooltipSheetDefinition` provides detailed information about
    /// a tooltip sheet within this analysis.
    tooltip_sheets: ?[]const TooltipSheetDefinition = null,

    pub const json_field_names = .{
        .analysis_defaults = "AnalysisDefaults",
        .calculated_fields = "CalculatedFields",
        .column_configurations = "ColumnConfigurations",
        .data_set_identifier_declarations = "DataSetIdentifierDeclarations",
        .filter_groups = "FilterGroups",
        .options = "Options",
        .parameter_declarations = "ParameterDeclarations",
        .query_execution_options = "QueryExecutionOptions",
        .sheets = "Sheets",
        .static_files = "StaticFiles",
        .tooltip_sheets = "TooltipSheets",
    };
};
