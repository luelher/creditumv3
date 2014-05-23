# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140522032944) do

  create_table "casas_comerciales", primary_key: "id_casa_comercial", force: true do |t|
    t.string "nombre",    limit: 60,  null: false
    t.string "rif",       limit: 15
    t.string "nit",       limit: 15
    t.string "ubicacion", limit: 100
  end

  add_index "casas_comerciales", ["id_casa_comercial"], name: "INDEX_CC", using: :btree
  add_index "casas_comerciales", ["nombre"], name: "I_NOMBRE", using: :btree

  create_table "clientes", primary_key: "id_cliente", force: true do |t|
    t.integer "id_casa_comercial"
    t.string  "nombre",            limit: 30, null: false
    t.string  "rif",               limit: 15
    t.string  "nit",               limit: 15
    t.string  "direccion",         limit: 50
    t.string  "telefono",          limit: 20
    t.string  "fax",               limit: 20
    t.string  "celular",           limit: 20
    t.string  "email",             limit: 50
  end

  add_index "clientes", ["id_cliente"], name: "INDEX_ID", unique: true, using: :btree
  add_index "clientes", ["nombre"], name: "I_CNOMBRE", using: :btree

  create_table "clientes_conf", primary_key: "id_cliente", force: true do |t|
    t.integer "descuento", null: false
    t.integer "consultas", null: false
    t.integer "aportes",   null: false
    t.date    "fecha_ini"
    t.integer "status",    null: false
  end

  add_index "clientes_conf", ["fecha_ini"], name: "Fecha_Ini", using: :btree
  add_index "clientes_conf", ["id_cliente"], name: "Indice_Clientes_conf", using: :btree

  create_table "clientes_personas", primary_key: "id_cliente_persona", force: true do |t|
    t.string  "id_persona", limit: 15, null: false
    t.integer "id_cliente",            null: false
  end

  add_index "clientes_personas", ["id_cliente"], name: "INDEX_CLIENTE", using: :btree
  add_index "clientes_personas", ["id_cliente_persona"], name: "INDEX_CLIENTE_PERSONA", using: :btree
  add_index "clientes_personas", ["id_persona"], name: "INDEX_PERSONA", using: :btree

  create_table "consultas", force: true do |t|
    t.integer  "cedula_usuario",            null: false
    t.integer  "id_cliente",                null: false
    t.string   "id_persona",     limit: 15, null: false
    t.datetime "fecha_hora",                null: false
  end

  add_index "consultas", ["cedula_usuario"], name: "I_USR", using: :btree
  add_index "consultas", ["id_cliente"], name: "I_CLIENTE", using: :btree
  add_index "consultas", ["id_persona"], name: "I_PERSONA", using: :btree

  create_table "consultas_fallidas", force: true do |t|
    t.integer  "cedula_usuario",            null: false
    t.integer  "id_cliente",                null: false
    t.string   "id_persona",     limit: 15, null: false
    t.datetime "fecha_hora",                null: false
  end

  add_index "consultas_fallidas", ["cedula_usuario"], name: "INDEX_USR", using: :btree
  add_index "consultas_fallidas", ["id_cliente"], name: "INDEX_CLIENTE", using: :btree
  add_index "consultas_fallidas", ["id_persona"], name: "INDEX_PERSONA", using: :btree

  create_table "creditos", force: true do |t|
    t.integer "id_cliente_persona",            null: false
    t.string  "factura",            limit: 20, null: false
    t.date    "fecha_compra"
    t.date    "fecha_operacion"
    t.float   "monto",                         null: false
    t.float   "pago_mes",                      null: false
    t.integer "num_giros",          limit: 1,  null: false
    t.integer "experiencia",        limit: 1,  null: false
    t.integer "estado",             limit: 1,  null: false
  end

  add_index "creditos", ["factura"], name: "INDEX_FACTURA", using: :btree
  add_index "creditos", ["fecha_compra"], name: "INDEX_FECHA_C", using: :btree
  add_index "creditos", ["fecha_operacion"], name: "INDEX_FECHA_O", using: :btree
  add_index "creditos", ["id"], name: "INDEX_ID", unique: true, using: :btree
  add_index "creditos", ["id_cliente_persona"], name: "INDEX_ID_CP", using: :btree

  create_table "detalle_facturas", id: false, force: true do |t|
    t.integer  "id_factura",                null: false
    t.integer  "cedula_usuario",            null: false
    t.string   "id_persona",     limit: 15, null: false
    t.datetime "fecha_hora",                null: false
    t.integer  "status",                    null: false
  end

  create_table "direcciones", primary_key: "id_persona", force: true do |t|
    t.string "direccion", limit: 50, null: false
  end

  create_table "empresa_conf", id: false, force: true do |t|
    t.integer "id_cliente",                null: false
    t.string  "web",            limit: 50, null: false
    t.float   "precio_ok1"
    t.float   "precio_ok2"
    t.float   "precio_ok3"
    t.float   "precio_ok4"
    t.float   "precio_fallida"
  end

  create_table "facturas", primary_key: "id_factura", force: true do |t|
    t.integer "id_cliente",     null: false
    t.date    "fecha_desde"
    t.date    "fecha_hasta"
    t.float   "precio_ok",      null: false
    t.float   "precio_fallida", null: false
    t.integer "validas",        null: false
    t.float   "totalv",         null: false
    t.integer "fallidas",       null: false
    t.float   "totalf",         null: false
    t.integer "descuento",      null: false
    t.float   "totald",         null: false
    t.float   "total",          null: false
  end

  add_index "facturas", ["id_cliente"], name: "Indice_cli", using: :btree
  add_index "facturas", ["id_factura"], name: "Indice_Facturas", using: :btree

  create_table "nivel", primary_key: "id_nivel", force: true do |t|
    t.string "descripcion", limit: 50, null: false
  end

  add_index "nivel", ["id_nivel"], name: "Index_Nivel", unique: true, using: :btree

  create_table "personas_juridicas", primary_key: "rif", force: true do |t|
    t.string "nit",       limit: 10,  null: false
    t.string "nombre",    limit: 30,  null: false
    t.string "telefono",  limit: 15
    t.string "direccion", limit: 100
    t.string "fax",       limit: 15
    t.string "email",     limit: 30
  end

  add_index "personas_juridicas", ["nit"], name: "Indice_Personas_Juridicas_NIT", using: :btree
  add_index "personas_juridicas", ["rif"], name: "Indice_Personas_Juridicas_RIF", using: :btree

  create_table "personas_naturales", primary_key: "cedula", force: true do |t|
    t.string "nombre",       limit: 30,                        null: false
    t.string "apellido",     limit: 30,                        null: false
    t.string "telefono",     limit: 15
    t.string "celular",      limit: 15
    t.string "profesion",    limit: 16
    t.string "nacionalidad", limit: 10, default: "VENEZOLANO"
    t.date   "fecha_nac"
    t.string "sexo",         limit: 1
  end

  add_index "personas_naturales", ["cedula"], name: "INDEX_CI", unique: true, using: :btree

  create_table "sf_guard_group", force: true do |t|
    t.string "name",        null: false
    t.text   "description"
  end

  add_index "sf_guard_group", ["name"], name: "sf_guard_group_U_1", unique: true, using: :btree

  create_table "sf_guard_group_permission", id: false, force: true do |t|
    t.integer "group_id",      null: false
    t.integer "permission_id", null: false
  end

  add_index "sf_guard_group_permission", ["permission_id"], name: "sf_guard_group_permission_FI_2", using: :btree

  create_table "sf_guard_permission", force: true do |t|
    t.string "name",        null: false
    t.text   "description"
  end

  add_index "sf_guard_permission", ["name"], name: "sf_guard_permission_U_1", unique: true, using: :btree

  create_table "sf_guard_remember_key", id: false, force: true do |t|
    t.integer  "user_id",                 null: false
    t.string   "remember_key", limit: 32
    t.string   "ip_address",   limit: 50, null: false
    t.datetime "created_at"
  end

  create_table "sf_guard_user", force: true do |t|
    t.string   "username",       limit: 128,                  null: false
    t.string   "algorithm",      limit: 128, default: "sha1", null: false
    t.string   "salt",           limit: 128,                  null: false
    t.string   "password",       limit: 128,                  null: false
    t.datetime "created_at"
    t.datetime "last_login"
    t.integer  "is_active",      limit: 1,   default: 1,      null: false
    t.integer  "is_super_admin", limit: 1,   default: 0,      null: false
  end

  add_index "sf_guard_user", ["username"], name: "sf_guard_user_U_1", unique: true, using: :btree

  create_table "sf_guard_user_group", id: false, force: true do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
  end

  add_index "sf_guard_user_group", ["group_id"], name: "sf_guard_user_group_FI_2", using: :btree

  create_table "sf_guard_user_permission", id: false, force: true do |t|
    t.integer "user_id",       null: false
    t.integer "permission_id", null: false
  end

  add_index "sf_guard_user_permission", ["permission_id"], name: "sf_guard_user_permission_FI_2", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "cedula"
  end

  add_index "users", ["cedula"], name: "index_users_on_cedula", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "usuarios", id: false, force: true do |t|
    t.integer "cedula",                                         null: false
    t.integer "id_cliente",                                     null: false
    t.string  "pwd",          limit: 50,                        null: false
    t.string  "nombre",       limit: 20,                        null: false
    t.string  "apellido",     limit: 20,                        null: false
    t.string  "telefono",     limit: 15
    t.string  "celular",      limit: 15
    t.string  "nacionalidad", limit: 10, default: "VENEZOLANO"
    t.boolean "id_nivel",                                       null: false
    t.date    "fecha"
  end

  add_index "usuarios", ["cedula"], name: "INDEX_CI", using: :btree
  add_index "usuarios", ["pwd"], name: "INDEX_PWD", using: :btree

end
