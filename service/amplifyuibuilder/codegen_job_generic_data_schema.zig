const aws = @import("aws");

const CodegenJobGenericDataSourceType = @import("codegen_job_generic_data_source_type.zig").CodegenJobGenericDataSourceType;
const CodegenGenericDataEnum = @import("codegen_generic_data_enum.zig").CodegenGenericDataEnum;
const CodegenGenericDataModel = @import("codegen_generic_data_model.zig").CodegenGenericDataModel;
const CodegenGenericDataNonModel = @import("codegen_generic_data_non_model.zig").CodegenGenericDataNonModel;

/// Describes the data schema for a code generation job.
pub const CodegenJobGenericDataSchema = struct {
    /// The type of the data source for the schema. Currently, the only valid value
    /// is an Amplify `DataStore`.
    data_source_type: CodegenJobGenericDataSourceType,

    /// The name of a `CodegenGenericDataEnum`.
    enums: []const aws.map.MapEntry(CodegenGenericDataEnum),

    /// The name of a `CodegenGenericDataModel`.
    models: []const aws.map.MapEntry(CodegenGenericDataModel),

    /// The name of a `CodegenGenericDataNonModel`.
    non_models: []const aws.map.MapEntry(CodegenGenericDataNonModel),

    pub const json_field_names = .{
        .data_source_type = "dataSourceType",
        .enums = "enums",
        .models = "models",
        .non_models = "nonModels",
    };
};
