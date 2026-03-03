/// Contains information about attribute-based access control (ABAC) for a
/// training job. The session chaining configuration uses Amazon Security Token
/// Service (STS) for your training job to request temporary, limited-privilege
/// credentials to tenants. For more information, see [Attribute-based access
/// control (ABAC) for multi-tenancy
/// training](https://docs.aws.amazon.com/sagemaker/latest/dg/model-access-training-data.html#model-access-training-data-abac).
pub const SessionChainingConfig = struct {
    /// Set to `True` to allow SageMaker to extract session tags from a training job
    /// creation role and reuse these tags when assuming the training job execution
    /// role.
    enable_session_tag_chaining: ?bool = null,

    pub const json_field_names = .{
        .enable_session_tag_chaining = "EnableSessionTagChaining",
    };
};
