const AmazonQPropertiesOutput = @import("amazon_q_properties_output.zig").AmazonQPropertiesOutput;
const AthenaPropertiesOutput = @import("athena_properties_output.zig").AthenaPropertiesOutput;
const GluePropertiesOutput = @import("glue_properties_output.zig").GluePropertiesOutput;
const HyperPodPropertiesOutput = @import("hyper_pod_properties_output.zig").HyperPodPropertiesOutput;
const IamPropertiesOutput = @import("iam_properties_output.zig").IamPropertiesOutput;
const MlflowPropertiesOutput = @import("mlflow_properties_output.zig").MlflowPropertiesOutput;
const RedshiftPropertiesOutput = @import("redshift_properties_output.zig").RedshiftPropertiesOutput;
const S3PropertiesOutput = @import("s3_properties_output.zig").S3PropertiesOutput;
const SparkEmrPropertiesOutput = @import("spark_emr_properties_output.zig").SparkEmrPropertiesOutput;
const SparkGluePropertiesOutput = @import("spark_glue_properties_output.zig").SparkGluePropertiesOutput;

/// The properties of a connection.
pub const ConnectionPropertiesOutput = union(enum) {
    /// The Amazon Q properties of the connection.
    amazon_q_properties: ?AmazonQPropertiesOutput,
    /// The Amazon Athena properties of a connection.
    athena_properties: ?AthenaPropertiesOutput,
    /// The Amazon Web Services Glue properties of a connection.
    glue_properties: ?GluePropertiesOutput,
    /// The hyper pod properties of a connection.
    hyper_pod_properties: ?HyperPodPropertiesOutput,
    /// The IAM properties of a connection.
    iam_properties: ?IamPropertiesOutput,
    /// The MLflow properties of a connection.
    mlflow_properties: ?MlflowPropertiesOutput,
    /// The Amazon Redshift properties of a connection.
    redshift_properties: ?RedshiftPropertiesOutput,
    /// The Amazon S3 properties of a connection.
    s_3_properties: ?S3PropertiesOutput,
    /// The Spark EMR properties of a connection.
    spark_emr_properties: ?SparkEmrPropertiesOutput,
    /// The Spark Amazon Web Services Glue properties of a connection.
    spark_glue_properties: ?SparkGluePropertiesOutput,

    pub const json_field_names = .{
        .amazon_q_properties = "amazonQProperties",
        .athena_properties = "athenaProperties",
        .glue_properties = "glueProperties",
        .hyper_pod_properties = "hyperPodProperties",
        .iam_properties = "iamProperties",
        .mlflow_properties = "mlflowProperties",
        .redshift_properties = "redshiftProperties",
        .s_3_properties = "s3Properties",
        .spark_emr_properties = "sparkEmrProperties",
        .spark_glue_properties = "sparkGlueProperties",
    };
};
