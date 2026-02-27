pub const GroupBy = enum {
    resources_affected_s_3_bucket_name,
    type,
    classification_details_job_id,
    severity_description,

    pub const json_field_names = .{
        .resources_affected_s_3_bucket_name = "resourcesAffected_s3Bucket_name",
        .type = "type",
        .classification_details_job_id = "classificationDetails_jobId",
        .severity_description = "severity_description",
    };
};
