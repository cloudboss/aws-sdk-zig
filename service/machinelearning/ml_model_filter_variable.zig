const std = @import("std");

pub const MLModelFilterVariable = enum {
    created_at,
    last_updated_at,
    status,
    name,
    iam_user,
    training_datasource_id,
    real_time_endpoint_status,
    ml_model_type,
    algorithm,
    training_data_uri,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .name = "Name",
        .iam_user = "IAMUser",
        .training_datasource_id = "TrainingDataSourceId",
        .real_time_endpoint_status = "RealtimeEndpointStatus",
        .ml_model_type = "MLModelType",
        .algorithm = "Algorithm",
        .training_data_uri = "TrainingDataURI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_at => "CreatedAt",
            .last_updated_at => "LastUpdatedAt",
            .status => "Status",
            .name => "Name",
            .iam_user => "IAMUser",
            .training_datasource_id => "TrainingDataSourceId",
            .real_time_endpoint_status => "RealtimeEndpointStatus",
            .ml_model_type => "MLModelType",
            .algorithm => "Algorithm",
            .training_data_uri => "TrainingDataURI",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
