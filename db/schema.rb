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

ActiveRecord::Schema.define(version: 20141009200908) do

  create_table "audits", force: true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.text     "modifications"
    t.string   "action"
    t.string   "tag"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "audits", ["action"], name: "index_audits_on_action", using: :btree
  add_index "audits", ["auditable_id", "auditable_type", "version"], name: "auditable_version_idx", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["tag"], name: "index_audits_on_tag", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "cargos", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dependencias", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "codigo",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "organismo_id"
    t.string   "alias"
  end

  create_table "entidades", force: true do |t|
    t.integer  "persona_id"
    t.integer  "dependencia_id"
    t.integer  "cargo_id"
    t.boolean  "es_facultad",    default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "es_actual"
  end

  create_table "estados_nota", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notas", force: true do |t|
    t.string   "tema"
    t.text     "descripcion"
    t.date     "fecha_ingreso"
    t.string   "codigo"
    t.integer  "tipo_nota_id"
    t.integer  "remitente_id"
    t.integer  "destinatario_id"
    t.datetime "fecha_eliminada"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.date     "fecha_nota"
    t.date     "fecha_carga"
    t.integer  "tipo"
    t.integer  "estado"
    t.integer  "cargado_por_id"
    t.integer  "recibido_por_id"
    t.integer  "parent_id"
    t.boolean  "cargado_mesa_entrada"
    t.boolean  "eliminada",            default: false
    t.string   "nro_referencia"
    t.integer  "estado_nota_id"
  end

  add_index "notas", ["estado_nota_id"], name: "index_notas_on_estado_nota_id", using: :btree

  create_table "notas_attachment", force: true do |t|
    t.integer  "nota_id"
    t.string   "filescan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notas_persona", force: true do |t|
    t.integer  "persona_id"
    t.integer  "nota_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notas_persona", ["nota_id"], name: "index_notas_persona_on_nota_id", using: :btree
  add_index "notas_persona", ["persona_id"], name: "index_notas_persona_on_persona_id", using: :btree

  create_table "notas_temporales", force: true do |t|
    t.string   "tema"
    t.string   "descripcion"
    t.date     "fecha_nota"
    t.date     "fecha_carga"
    t.string   "codigo"
    t.integer  "tipo_nota_id"
    t.integer  "remitente_id"
    t.string   "texto_remitente"
    t.integer  "destinatario_id"
    t.string   "texto_destinatario"
    t.integer  "cargado_por_id"
    t.integer  "dependencia_id"
    t.integer  "estado"
    t.integer  "nota_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notas_temporales", ["cargado_por_id"], name: "index_notas_temporales_on_cargado_por_id", using: :btree
  add_index "notas_temporales", ["dependencia_id"], name: "index_notas_temporales_on_dependencia_id", using: :btree
  add_index "notas_temporales", ["destinatario_id"], name: "index_notas_temporales_on_destinatario_id", using: :btree
  add_index "notas_temporales", ["nota_id"], name: "index_notas_temporales_on_nota_id", using: :btree
  add_index "notas_temporales", ["remitente_id"], name: "index_notas_temporales_on_remitente_id", using: :btree
  add_index "notas_temporales", ["tipo_nota_id"], name: "index_notas_temporales_on_tipo_nota_id", using: :btree

  create_table "note_types", force: true do |t|
    t.string   "name"
    t.string   "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organismos", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "codigo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "alias"
  end

  create_table "personas", force: true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessiones", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessiones", ["session_id"], name: "index_sessiones_on_session_id", using: :btree
  add_index "sessiones", ["updated_at"], name: "index_sessiones_on_updated_at", using: :btree

  create_table "tipos_notas", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "rol_id"
    t.integer  "dependencia_id"
  end

  add_index "users", ["dependencia_id"], name: "index_users_on_dependencia_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["rol_id"], name: "index_users_on_rol_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.string   "ip"
    t.string   "user_agent"
    t.integer  "user_id"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
