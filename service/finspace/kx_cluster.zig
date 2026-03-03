const KxAzMode = @import("kx_az_mode.zig").KxAzMode;
const KxClusterType = @import("kx_cluster_type.zig").KxClusterType;
const KxClusterStatus = @import("kx_cluster_status.zig").KxClusterStatus;
const Volume = @import("volume.zig").Volume;

/// The details of a kdb cluster.
pub const KxCluster = struct {
    /// The availability zone identifiers for the requested regions.
    availability_zone_id: ?[]const u8 = null,

    /// The number of availability zones assigned per cluster. This can be one of
    /// the following:
    ///
    /// * `SINGLE` – Assigns one availability zone per cluster.
    ///
    /// * `MULTI` – Assigns all the availability zones per cluster.
    az_mode: ?KxAzMode = null,

    /// A description of the cluster.
    cluster_description: ?[]const u8 = null,

    /// A unique name for the cluster.
    cluster_name: ?[]const u8 = null,

    /// Specifies the type of KDB database that is being created. The following
    /// types are available:
    ///
    /// * HDB – A Historical Database. The data is only accessible with read-only
    ///   permissions from one of the FinSpace managed kdb databases mounted to the
    ///   cluster.
    ///
    /// * RDB – A Realtime Database. This type of database captures all the data
    ///   from a ticker plant and stores it in memory until the end of day, after
    ///   which it writes all of its data to a disk and reloads the HDB. This
    ///   cluster type requires local storage for temporary storage of data during
    ///   the savedown process. If you specify this field in your request, you must
    ///   provide the `savedownStorageConfiguration` parameter.
    ///
    /// * GATEWAY – A gateway cluster allows you to access data across processes in
    ///   kdb systems. It allows you to create your own routing logic using the
    ///   initialization scripts and custom code. This type of cluster does not
    ///   require a writable local storage.
    ///
    /// * GP – A general purpose cluster allows you to quickly iterate on code
    ///   during development by granting greater access to system commands and
    ///   enabling a fast reload of custom code. This cluster type can optionally
    ///   mount databases including cache and savedown storage. For this cluster
    ///   type, the node count is fixed at 1. It does not support autoscaling and
    ///   supports only `SINGLE` AZ mode.
    ///
    /// * Tickerplant – A tickerplant cluster allows you to subscribe to feed
    ///   handlers based on IAM permissions. It can publish to RDBs, other
    ///   Tickerplants, and real-time subscribers (RTS). Tickerplants can persist
    ///   messages to log, which is readable by any RDB environment. It supports
    ///   only single-node that is only one kdb process.
    cluster_type: ?KxClusterType = null,

    /// The timestamp at which the cluster was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// An IAM role that defines a set of permissions associated with a cluster.
    /// These permissions are assumed when a cluster attempts to access another
    /// cluster.
    execution_role: ?[]const u8 = null,

    /// Specifies a Q program that will be run at launch of a cluster. It is a
    /// relative path within
    /// *.zip* file that contains the custom code, which will be loaded on
    /// the cluster. It must include the file name itself. For example,
    /// `somedir/init.q`.
    initialization_script: ?[]const u8 = null,

    /// The last time that the cluster was modified. The value is determined as
    /// epoch time in milliseconds. For example, the value for Monday, November 1,
    /// 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    /// A version of the FinSpace managed kdb to run.
    release_label: ?[]const u8 = null,

    /// The status of a cluster.
    ///
    /// * PENDING – The cluster is pending creation.
    ///
    /// * CREATING –The cluster creation process is in progress.
    ///
    /// * CREATE_FAILED– The cluster creation process has failed.
    ///
    /// * RUNNING – The cluster creation process is running.
    ///
    /// * UPDATING – The cluster is in the process of being updated.
    ///
    /// * DELETING – The cluster is in the process of being deleted.
    ///
    /// * DELETED – The cluster has been deleted.
    ///
    /// * DELETE_FAILED – The cluster failed to delete.
    status: ?KxClusterStatus = null,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8 = null,

    /// A list of volumes attached to the cluster.
    volumes: ?[]const Volume = null,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .az_mode = "azMode",
        .cluster_description = "clusterDescription",
        .cluster_name = "clusterName",
        .cluster_type = "clusterType",
        .created_timestamp = "createdTimestamp",
        .execution_role = "executionRole",
        .initialization_script = "initializationScript",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .release_label = "releaseLabel",
        .status = "status",
        .status_reason = "statusReason",
        .volumes = "volumes",
    };
};
