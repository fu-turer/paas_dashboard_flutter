import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paas_dashboard_flutter/module/ssh/ssh_step.dart';
import 'package:paas_dashboard_flutter/persistent/persistent_api.dart';
import 'package:paas_dashboard_flutter/persistent/persistent_db.dart';
import 'package:paas_dashboard_flutter/persistent/persistent_memory.dart';
import 'package:paas_dashboard_flutter/persistent/po/bk_instance_po.dart';
import 'package:paas_dashboard_flutter/persistent/po/k8s_instance_po.dart';
import 'package:paas_dashboard_flutter/persistent/po/mongo_instance_po.dart';
import 'package:paas_dashboard_flutter/persistent/po/mysql_instance_po.dart';
import 'package:paas_dashboard_flutter/persistent/po/pulsar_instance_po.dart';

class Persistent {
  static PersistentApi? api;

  static Future<PersistentApi> getApi() async {
    if (api == null) {
      if (!kIsWeb) {
        api = await PersistentDb.getInstance();
      } else {
        api = new PersistentMemory();
      }
    }
    return api!;
  }

  static Future<void> savePulsar(String name, String host, int port, String functionHost, int functionPort) async {
    return (await getApi()).savePulsar(name, host, port, functionHost, functionPort);
  }

  static Future<void> deletePulsar(int id) async {
    return (await getApi()).deletePulsar(id);
  }

  static Future<List<PulsarInstancePo>> pulsarInstances() async {
    return (await getApi()).pulsarInstances();
  }

  static Future<void> saveBookkeeper(String name, String host, int port) async {
    return (await getApi()).saveBookkeeper(name, host, port);
  }

  static Future<void> deleteBookkeeper(int id) async {
    return (await getApi()).deleteBookkeeper(id);
  }

  static Future<List<BkInstancePo>> bookkeeperInstances() async {
    return (await getApi()).bookkeeperInstances();
  }

  static Future<void> saveKubernetesSsh(String name, List<SshStep> sshSteps) async {
    return (await getApi()).saveKubernetesSsh(name, sshSteps);
  }

  static Future<void> deleteKubernetes(int id) async {
    return (await getApi()).deleteKubernetes(id);
  }

  static Future<List<K8sInstancePo>> kubernetesInstances() async {
    return (await getApi()).kubernetesInstances();
  }

  static Future<void> saveMongo(String name, String addr, String username, String password) async {
    return (await getApi()).saveMongo(name, addr, username, password);
  }

  static Future<void> deleteMongo(int id) async {
    return (await getApi()).deleteMongo(id);
  }

  static Future<List<MongoInstancePo>> mongoInstances() async {
    return (await getApi()).mongoInstances();
  }

  static Future<void> saveMysql(String name, String host, int port, String username, String password) async {
    return (await getApi()).saveMysql(name, host, port, username, password);
  }

  static Future<void> deleteMysql(int id) async {
    return (await getApi()).deleteMysql(id);
  }

  static Future<List<MysqlInstancePo>> mysqlInstances() async {
    return (await getApi()).mysqlInstances();
  }

  static bool supportDb() {
    return !kIsWeb;
  }
}
