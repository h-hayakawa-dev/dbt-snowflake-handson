{# generate_schema_name = dbtが「このモデルをどのスキーマに作るか」決める時に必ず呼ぶ関数。同名で自作すると上書きできる #}
{# 引数: custom_schema_name = ymlの +schema 値(例: HANDSON) / node = 対象モデルの情報(今回は未使用) #}
{% macro generate_schema_name(custom_schema_name, node) -%}

    {#- target.schema = 接続profileで設定したスキーマ。開発なら DBT_HIDEOMI、PROJECTなら PROJECT -#}
    {%- set default_schema = target.schema -%}

    {#- 【分岐1】本番系(stg/prod) かつ ymlにschema指定があるとき -#}
    {%- if target.name in ['stg', 'prod'] and custom_schema_name is not none -%}
        {#- → yml指定名をそのまま使う。例: HANDSON -#}
        {{ custom_schema_name | trim }}

    {#- 【分岐2】それ以外(開発IDE=default / CI=project) かつ ymlにschema指定があるとき -#}
    {%- elif custom_schema_name is not none -%}
        {#- → 「自分のスキーマ名_yml指定名」に連結して隔離。例: DBT_HIDEOMI_HANDSON -#}
        {{ default_schema }}_{{ custom_schema_name | trim }}

    {#- 【分岐3】ymlにschema指定が無いモデル(フォールバック) -#}
    {%- else -%}
        {#- → プレフィックスのスキーマ名だけ使う -#}
        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}
