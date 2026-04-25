const AmazonQPropertiesInput = @import("amazon_q_properties_input.zig").AmazonQPropertiesInput;
const AthenaPropertiesInput = @import("athena_properties_input.zig").AthenaPropertiesInput;
const GluePropertiesInput = @import("glue_properties_input.zig").GluePropertiesInput;
const HyperPodPropertiesInput = @import("hyper_pod_properties_input.zig").HyperPodPropertiesInput;
const IamPropertiesInput = @import("iam_properties_input.zig").IamPropertiesInput;
const LakehousePropertiesInput = @import("lakehouse_properties_input.zig").LakehousePropertiesInput;
const MlflowPropertiesInput = @import("mlflow_properties_input.zig").MlflowPropertiesInput;
const RedshiftPropertiesInput = @import("redshift_properties_input.zig").RedshiftPropertiesInput;
const S3PropertiesInput = @import("s3_properties_input.zig").S3PropertiesInput;
const SparkEmrPropertiesInput = @import("spark_emr_properties_input.zig").SparkEmrPropertiesInput;
const SparkGluePropertiesInput = @import("spark_glue_properties_input.zig").SparkGluePropertiesInput;
const WorkflowsMwaaPropertiesInput = @import("workflows_mwaa_properties_input.zig").WorkflowsMwaaPropertiesInput;
const WorkflowsServerlessPropertiesInput = @import("workflows_serverless_properties_input.zig").WorkflowsServerlessPropertiesInput;

/// The properties of a connection.
pub const ConnectionPropertiesInput = union(enum) {
    /// The Amazon Q properties of the connection.
    amazon_q_properties: ?AmazonQPropertiesInput,
    /// The Amazon Athena properties of a connection.
    athena_properties: ?AthenaPropertiesInput,
    /// The Amazon Web Services Glue properties of a connection.
    glue_properties: ?GluePropertiesInput,
    /// The hyper pod properties of a connection.
    hyper_pod_properties: ?HyperPodPropertiesInput,
    /// The IAM properties of a connection.
    iam_properties: ?IamPropertiesInput,
    /// The lakehouse properties of a connection.
    lakehouse_properties: ?LakehousePropertiesInput,
    /// The MLflow properties of a connection.
    mlflow_properties: ?MlflowPropertiesInput,
    /// The Amazon Redshift properties of a connection.
    redshift_properties: ?RedshiftPropertiesInput,
    /// The Amazon S3 properties of a connection.
    s_3_properties: ?S3PropertiesInput,
    /// The Spark EMR properties of a connection.
    spark_emr_properties: ?SparkEmrPropertiesInput,
    /// The Spark Amazon Web Services Glue properties of a connection.
    spark_glue_properties: ?SparkGluePropertiesInput,
    /// The Amazon MWAA properties of a connection.
    workflows_mwaa_properties: ?WorkflowsMwaaPropertiesInput,
    /// The MWAA serverless properties of a connection.
    workflows_serverless_properties: ?WorkflowsServerlessPropertiesInput,

    pub const json_field_names = .{
        .amazon_q_properties = "amazonQProperties",
        .athena_properties = "athenaProperties",
        .glue_properties = "glueProperties",
        .hyper_pod_properties = "hyperPodProperties",
        .iam_properties = "iamProperties",
        .lakehouse_properties = "lakehouseProperties",
        .mlflow_properties = "mlflowProperties",
        .redshift_properties = "redshiftProperties",
        .s_3_properties = "s3Properties",
        .spark_emr_properties = "sparkEmrProperties",
        .spark_glue_properties = "sparkGlueProperties",
        .workflows_mwaa_properties = "workflowsMwaaProperties",
        .workflows_serverless_properties = "workflowsServerlessProperties",
    };
};
