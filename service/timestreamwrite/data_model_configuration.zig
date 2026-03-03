const DataModel = @import("data_model.zig").DataModel;
const DataModelS3Configuration = @import("data_model_s3_configuration.zig").DataModelS3Configuration;

pub const DataModelConfiguration = struct {
    data_model: ?DataModel = null,

    data_model_s3_configuration: ?DataModelS3Configuration = null,

    pub const json_field_names = .{
        .data_model = "DataModel",
        .data_model_s3_configuration = "DataModelS3Configuration",
    };
};
