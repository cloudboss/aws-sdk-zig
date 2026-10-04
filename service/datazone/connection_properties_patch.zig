const AmazonQPropertiesPatch = @import("amazon_q_properties_patch.zig").AmazonQPropertiesPatch;
const AthenaPropertiesPatch = @import("athena_properties_patch.zig").AthenaPropertiesPatch;
const GitPropertiesPatch = @import("git_properties_patch.zig").GitPropertiesPatch;
const GluePropertiesPatch = @import("glue_properties_patch.zig").GluePropertiesPatch;
const IamPropertiesPatch = @import("iam_properties_patch.zig").IamPropertiesPatch;
const LakehousePropertiesPatch = @import("lakehouse_properties_patch.zig").LakehousePropertiesPatch;
const MlflowPropertiesPatch = @import("mlflow_properties_patch.zig").MlflowPropertiesPatch;
const RedshiftPropertiesPatch = @import("redshift_properties_patch.zig").RedshiftPropertiesPatch;
const S3PropertiesPatch = @import("s3_properties_patch.zig").S3PropertiesPatch;
const SnowflakePropertiesPatch = @import("snowflake_properties_patch.zig").SnowflakePropertiesPatch;
const SparkEmrPropertiesPatch = @import("spark_emr_properties_patch.zig").SparkEmrPropertiesPatch;
const VpcPropertiesPatch = @import("vpc_properties_patch.zig").VpcPropertiesPatch;

/// The connection properties patch.
pub const ConnectionPropertiesPatch = union(enum) {
    /// The Amazon Q properties of the connection.
    amazon_q_properties: ?AmazonQPropertiesPatch,
    /// The Amazon Athena properties of a connection properties patch.
    athena_properties: ?AthenaPropertiesPatch,
    /// The Git properties of a connection properties patch.
    git_properties: ?GitPropertiesPatch,
    /// The Amazon Web Services Glue properties of a connection properties patch.
    glue_properties: ?GluePropertiesPatch,
    /// The IAM properties of a connection properties patch.
    iam_properties: ?IamPropertiesPatch,
    /// The lakehouse properties of a connection properties patch.
    lakehouse_properties: ?LakehousePropertiesPatch,
    /// The MLflow properties of a connection.
    mlflow_properties: ?MlflowPropertiesPatch,
    /// The Amazon Redshift properties of a connection properties patch.
    redshift_properties: ?RedshiftPropertiesPatch,
    /// The Amazon S3 properties of a connection properties patch.
    s_3_properties: ?S3PropertiesPatch,
    /// The Snowflake-specific connection properties to update.
    snowflake_properties: ?SnowflakePropertiesPatch,
    /// The Spark EMR properties of a connection properties patch.
    spark_emr_properties: ?SparkEmrPropertiesPatch,
    /// The VPC properties of a connection properties patch.
    vpc_properties: ?VpcPropertiesPatch,

    pub const json_field_names = .{
        .amazon_q_properties = "amazonQProperties",
        .athena_properties = "athenaProperties",
        .git_properties = "gitProperties",
        .glue_properties = "glueProperties",
        .iam_properties = "iamProperties",
        .lakehouse_properties = "lakehouseProperties",
        .mlflow_properties = "mlflowProperties",
        .redshift_properties = "redshiftProperties",
        .s_3_properties = "s3Properties",
        .snowflake_properties = "snowflakeProperties",
        .spark_emr_properties = "sparkEmrProperties",
        .vpc_properties = "vpcProperties",
    };
};
