require 'common.ijs'

hor =: 0
ver =: 0
aim =: 0

up =: {{ aim =: aim - y }}
down =: {{ aim =: aim + y }}
forward =: {{ 
  hor =: hor + y
  ver =: ver + aim * y
}}

navigate =: {{ load y }}
